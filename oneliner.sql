select 
sender.*,
receiver.*

from participants as sender
cross join 
(
SELECT ABS(RANDOM() % (select count(*)  - 1 from participants)) + 1 as offset
) as randomOffset
inner join participants as receiver
on receiver.id = (sender.id + randomOffset.offset) % (select count(*) from participants)