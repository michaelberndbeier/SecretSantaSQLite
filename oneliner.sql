select 
randomOffset.offset,
senderInfo.*,
receiverInfo.*

from (
select 
sender.id as senderId,
receiver.id as receiverId
from participants as sender
cross join participants as receiver) as allPairings
cross join 
(
SELECT ABS(RANDOM() % (select count(*)  - 1 from participants)) + 1 as offset
) as randomOffset
inner join participants as senderInfo
on allPairings.senderId = senderInfo.id
inner join participants as receiverInfo
on allPairings.receiverId = receiverInfo.id

where allPairings.receiverId = (allPairings.senderId + randomOffset.offset) % (select count(*) from participants)