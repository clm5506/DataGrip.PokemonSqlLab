-- #What are all the types of pokemon that a pokemon can have?
SELECT name
FROM types;

-- #What is the name of the pokemon with id 45?
SELECT name
FROM pokemons
WHERE id = 45;

-- #How many pokemon are there?
SELECT COUNT(*)
FROM pokemons;

-- #How many types are there?
SELECT COUNT(*)
FROM types;

-- #How many pokemon have a secondary type?
SELECT COUNT(*)
FROM pokemons
WHERE secondary_type IS NOT NULL;

-- #What is each pokemon's primary type?
SELECT p.name, t.name
FROM pokemons p,
     types t
WHERE p.primary_type = t.id;

-- #What is Rufflet's secondary type?
SELECT p.name, t.name
FROM pokemons p,
     types t
WHERE p.name = 'Rufflet'
  AND p.secondary_type = t.id;

-- #What are the names of the pokemon that belong to the trainer with trainerID 303?
SELECT p.name
FROM pokemons p,
     pokemon_trainer pt
WHERE pt.trainerID = 303
  AND pt.pokemon_id = p.id;

-- #How many pokemon have a secondary type Poison
SELECT COUNT(*)
FROM pokemons p,
     types t
WHERE p.secondary_type = t.id
  AND t.name = 'Poison';

-- #What are all the primary types and how many pokemon have that type?
SELECT t.name, COUNT(*)
FROM types t,
     pokemons p
WHERE p.primary_type = t.id
GROUP BY p.primary_type;

-- # How many pokemon at level 100 does each trainer with at least one level 100 pokemon have?
SELECT pt.trainerID, COUNT(*)
FROM pokemon_trainer pt
WHERE pt.pokelevel = '100'
GROUP BY pt.trainerID;

-- # How many pokemon only belong to one trainer and no other?
SELECT COUNT(*)
FROM (SELECT COUNT(pt.pokemon_id) FROM pokemon_trainer pt GROUP BY pokemon_id HAVING COUNT(*) = 1) a;

-- # Directions: Write a query that returns the following columns:
-- # Sort the data by finding out which trainer has the strongest pokemon
-- # so that this will act as a ranking of strongest to weakest trainer.
-- # You may interpret strongest in whatever way you want, but you will have to explain your decision.
-- # Strength was determined by highest level to lowest because the pokemon with the most strength would have achieved the highest level
SELECT p.name as 'Pokemon Name',
       t.trainername as 'Trainer Name',
       pt.pokelevel as 'Level',
       ty.name as 'Primary Type',
       tys.name as 'Secondary Type'

FROM pokemon_trainer AS pt
LEFT OUTER JOIN trainers AS t ON t.trainerID = pt.trainerID
LEFT OUTER JOIN pokemons AS p ON p.id = pt.pokemon_id
LEFT OUTER JOIN types AS ty on p.primary_type = ty.id
LEFT OUTER JOIN types AS tys on p.secondary_type = tys.id
ORDER BY pt.pokelevel DESC;