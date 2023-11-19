USE desafio;
	-- Comandos de análise --
select *from vendas;
select *from frete;
select *from produtos;
select *from categorias;
-- -- -- -- -- -- -- -- -- --

	-- 01) Valor total das vendas e dos fretes por produto e ordem de venda;
    
desc vendas; -- Para analisar o formato das colunas
SELECT 
    v.ProdutoID,
    f.Data,
    CAST(v.Valor AS DECIMAL(10,4)) * CAST(v.Quantidade AS DECIMAL(10,4)) AS Valor,
	(f.ValorFrete) as valor_total_do_frete
FROM Vendas v
JOIN frete f ON v.CupomID = f.CupomID;

	-- 02) Valor de venda por tipo de produto;

SELECT
	c.Categoria,
    SUM(v.Valor*v.Quantidade) as valor_total_vendas
    FROM vendas v
    JOIN produtos p on v.ProdutoID = p.ProdutoID
    JOIN categorias c on c.CategoriaID = p.CategoriaID
    GROUP BY c.Categoria;
    
    -- 03) Quantidade e valor das vendas por dia, mês, ano;
    
SELECT 
    YEAR(STR_TO_DATE( f.Data , "%d/%m/%Y" )) AS Ano,
    MONTH(STR_TO_DATE( f.Data , "%d/%m/%Y" )) AS Mes,
    DAY(STR_TO_DATE( f.Data , "%d/%m/%Y" )) AS Dia,
    COUNT(*) AS quantidade_vendas,
	SUM(v.Valor) AS valor_total_vendas
FROM 
    vendas v
    JOIN frete f on v.CupomID = f.CupomID
GROUP BY 
    YEAR(STR_TO_DATE( f.Data , "%d/%m/%Y" )), MONTH(STR_TO_DATE( f.Data , "%d/%m/%Y" )), DAY(STR_TO_DATE( f.Data , "%d/%m/%Y" ))
ORDER BY 
    Ano, Mes, Dia;
    
    -- 04) Lucro dos meses;

SELECT
	c.Categoria,
    SUM(v.Valor*v.Quantidade) as valor_total_vendas
    from vendas v
    JOIN produtos p on v.ProdutoID = p.ProdutoID
    JOIN categorias c on c.CategoriaID = p.CategoriaID
    GROUP BY c.Categoria;
    
    -- 05) Quantidade e valor das vendas por dia, mês, ano;
    
SELECT 
    YEAR(STR_TO_DATE( f.Data , "%d/%m/%Y" )) AS Ano,
    MONTH(STR_TO_DATE( f.Data , "%d/%m/%Y" )) AS Mes,
    COUNT(*) AS quantidade_vendas,
	SUM(v.ValorLiquido) AS lucro_total_vendas
FROM 
    vendas v
    JOIN frete f on v.CupomID = f.CupomID
GROUP BY 
    YEAR(STR_TO_DATE( f.Data , "%d/%m/%Y" )), MONTH(STR_TO_DATE( f.Data , "%d/%m/%Y" ))
ORDER BY 
    Ano, Mes;
    
    -- 06) Venda por produto;
    
    SELECT 
    v.ProdutoID,
    SUM(v.Quantidade) as produtos_vendidos
FROM Vendas v
JOIN frete f ON v.CupomID = f.CupomID
GROUP BY v.ProdutoID;

	-- 07) Venda por cliente e cidade do cliente;
    
SELECT
    c.ClienteID,
    c.Cidade,
    SUM(v.Quantidade) as vendas_totais
FROM
    clientes c
JOIN
    frete f ON c.ClienteID = f.ClienteID
JOIN
    vendas v ON f.CupomID = v.CupomID
GROUP BY
    c.ClienteID, c.Cidade
ORDER BY
    c.Cidade, c.ClienteID;

	-- 08) Média de produtos vendidos;

SELECT
    p.ProdutoID,
    p.Produto,
    AVG(v.Quantidade) as media_de_produtos_vendidos
FROM
    produtos p
JOIN
    vendas v ON p.ProdutoID = v.ProdutoID
GROUP BY
    p.ProdutoID, p.Produto
ORDER BY
    p.ProdutoID;
    
	-- 09) Média de compras que um cliente faz

SELECT
    cl.ClienteID,
    AVG(v.Quantidade) as media_de_compras_por_cliente
FROM
    clientes cl
JOIN
    frete f ON cl.ClienteID = f.ClienteID
JOIN
    vendas v ON f.CupomID = v.CupomID
GROUP BY
    cl.ClienteID
ORDER BY
    cl.ClienteID;
