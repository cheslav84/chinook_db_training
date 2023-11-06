-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US. --
SELECT CONCAT("FirstName", ' ', "LastName") AS "Full Name", "CustomerId", "Country"
FROM "Customer"
WHERE "Country" NOT LIKE 'US%';

-- 2. Provide a query only showing the Customers from Brazil. --
SELECT *
FROM "Customer"
WHERE "Country" = 'Brazil';

-- 3. Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the
-- customer’s full name, Invoice ID, Date of the invoice and billing country. --
SELECT CONCAT(c."FirstName", ' ', c."LastName") AS "Customer Name", "InvoiceId", "InvoiceDate", "BillingCountry"
FROM "Customer" c
         JOIN "Invoice" i ON c."CustomerId" = i."CustomerId"
WHERE "Country" = 'Brazil';

-- 4. Provide a query showing only the Employees who are Sales Agents --
SELECT *
FROM "Employee"
WHERE "Title" LIKE 'Sales %Agent';

-- 5. Provide a query showing a unique list of billing countries from the Invoice table. --
SELECT DISTINCT "BillingCountry"
FROM "Invoice"
ORDER BY "BillingCountry";

-- 6. Provide a query that shows the invoices associated with each sales agent. The resultant table
-- should include the Sales Agent’s full name. --
SELECT CONCAT(e."FirstName", ' ', e."LastName") AS "Full Name", i."InvoiceDate", i."Total"
FROM "Invoice" i
         JOIN "Customer" c ON i."CustomerId" = c."CustomerId"
         JOIN "Employee" e ON c."SupportRepId" = e."EmployeeId";


-- 7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for
-- all invoices and customers. --
SELECT "Total", c."FirstName", c."LastName", c."Country", e."FirstName", e."LastName"
FROM "Customer" c
         JOIN "Invoice" i ON c."CustomerId" = i."CustomerId"
         JOIN "Employee" e ON c."SupportRepId" = e."EmployeeId";

-- 8. How many Invoices were there in 2009 and 2011? What are the respective total sales for each of
-- those years? --
SELECT DATE_PART('year', "InvoiceDate") AS year, COUNT("InvoiceId"), SUM("Total")
FROM "Invoice"
WHERE DATE_PART('year', "InvoiceDate") = '2009'
   OR DATE_PART('year', "InvoiceDate") = '2011'
GROUP BY year;

-- 9. How many Invoices were there in 2009 and 2011? What are the respective total sales for each of
-- those years? --
SELECT COUNT("InvoiceId")
FROM "InvoiceLine"
WHERE "InvoiceId" = 37;

-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for
-- each Invoice. HINT: GROUP BY --
SELECT "InvoiceId", COUNT("InvoiceId")
FROM "InvoiceLine"
GROUP BY "InvoiceId"
ORDER BY "InvoiceId";

--     11. Provide a query that includes the track name with each invoice line item.
SELECT "Name", i."InvoiceDate"
FROM "Track" t
         JOIN "InvoiceLine" il ON t."TrackId" = il."TrackId"
         JOIN "Invoice" i ON il."InvoiceId" = i."InvoiceId";

-- 12. Provide a query that includes the purchased track name AND artist name with each invoice line item.
SELECT t."Name" AS Track, ar."Name" AS Artist, il."InvoiceLineId"
FROM "Track" t
         JOIN "Album" al ON al."AlbumId" = t."AlbumId"
         JOIN "Artist" ar ON ar."ArtistId" = al."ArtistId"
         JOIN "InvoiceLine" il ON t."TrackId" = il."TrackId";

--     13. Provide a query that shows the # of invoices per country. HINT: GROUP BY
SELECT i."BillingCountry", count(i."BillingCountry")
FROM "Invoice" i
GROUP BY i."BillingCountry";

--     14. Provide a query that shows the total number of tracks in each playlist. The Playlist name
-- should be included on the resultant table.
SELECT pl."Name", count(pt."TrackId")
FROM "Playlist" pl
         LEFT JOIN "PlaylistTrack" pt ON pl."PlaylistId" = pt."PlaylistId" GROUP BY pl."Name";