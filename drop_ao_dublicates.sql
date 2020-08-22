DELETE FROM
    ao a
        USING ao b
WHERE
    a.updatedate < b.updatedate
    AND a.guid = b.guid;
    
DELETE FROM
    ao a
        USING ao b
WHERE
    a.startdate < b.startdate
    AND a.guid = b.guid;
    
    
DELETE FROM
    ao a
        USING ao b
WHERE
    a.ctid < b.ctid
    AND a.guid = b.guid;