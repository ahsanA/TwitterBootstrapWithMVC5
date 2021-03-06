USE [TestDB]
GO
/****** Object:  StoredProcedure [dbo].[Order_AddOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_AddOrder]
	@ID [uniqueidentifier],
	@OrderCost [decimal](18, 6)
AS
BEGIN
Declare @IDCount [int];

SELECT @IDCount = COUNT([ID]) FROM [dbo].[Order]
WHERE [ID] = @ID

IF @IDCount = 0
	BEGIN
		INSERT INTO [dbo].[Order]
			(
				[ID]
				,[OrderCost]
				)
			VALUES(@ID
				,@OrderCost
			)
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Order_DeleteOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_DeleteOrder]
	@ID [uniqueidentifier]
AS
BEGIN
SET NOCOUNT ON
	DELETE
		FROM [dbo].[Order] 
	WHERE ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[Order_EditOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_EditOrder]
	@ID [uniqueidentifier],
	@OrderCost [decimal](18, 6)
AS
BEGIN
Declare @IDCount [int];

SELECT @IDCount = COUNT([ID]) FROM [dbo].[Order]
WHERE [ID] = @ID

IF @IDCount > 0
	BEGIN
		UPDATE [dbo].[Order]
			SET
				[OrderCost]=@OrderCost
			WHERE [ID]=@ID			
	END
END
GO
/****** Object:  StoredProcedure [dbo].[Order_GetAllOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_GetAllOrder]
AS
BEGIN
SET NOCOUNT ON
	SELECT *
	FROM [Order]
END
GO
/****** Object:  StoredProcedure [dbo].[Order_GetAllOrder_Search]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_GetAllOrder_Search]
@SearchString nvarchar(MAX)
AS
BEGIN
SET NOCOUNT ON
	SELECT *
	FROM [Order]
	Where [OrderCost] LIKE '%'+@SearchString+'%'
END
GO
/****** Object:  StoredProcedure [dbo].[Order_GetAllPagedOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_GetAllPagedOrder]
	@CurrentPageIndex [int],
	@PageSize [int],
	@SortOrder [nvarchar](500),
	@ID [uniqueidentifier],
	@OrderCost [decimal](18, 6)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sql nvarchar(max),
	@paramlist  nvarchar(4000),
	@CurrentRowIndex int;

	SET @CurrentRowIndex = ((@CurrentPageIndex - 1) * @PageSize) + 1;

	SET @sql='
		WITH Custom_PageSegment AS (
			SELECT *,
			ROW_NUMBER() OVER ( ORDER BY ' + @SortOrder + ' ) as RowIndex
			FROM [dbo].[Order] sm
			WHERE 1=1'

		IF @ID IS NOT NULL
		SET @sql = @sql + ' AND sm.ID= @xID'
		IF @OrderCost IS NOT NULL
		SET @sql = @sql + ' AND sm.OrderCost= @xOrderCost'
		
SET @sql = @sql +
		')
		SELECT *
		FROM Custom_PageSegment
			WHERE
			RowIndex BETWEEN '
			+  CONVERT(nvarchar(10),@CurrentRowIndex)
			+ ' AND (' 
			+ CONVERT(nvarchar(10),@CurrentRowIndex) + ' + ' + CONVERT(nvarchar(10),@PageSize)
			+ ') - 1  order by '
			+ CONVERT(nvarchar(500),@SortOrder);
	SELECT @paramlist = 
		'@xID[uniqueidentifier]
		,@xOrderCost[decimal]
		'EXEC sp_executesql @sql, @paramlist, 
			@ID
			,@OrderCost
END
GO
/****** Object:  StoredProcedure [dbo].[Order_GetOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_GetOrder]
	@ID [uniqueidentifier]
AS
BEGIN
SET NOCOUNT ON
	SELECT *
	FROM [dbo].[Order]
	WHERE ID = @ID
END
GO
/****** Object:  StoredProcedure [dbo].[Order_TotalCountOrder]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Order_TotalCountOrder]
	@TotalCount [int] OUTPUT
AS
BEGIN
SET NOCOUNT ON
	SELECT
	@TotalCount = COUNT(*)
	FROM [dbo].[Order]
END
GO
/****** Object:  Table [dbo].[Order]    Script Date: 9/8/2014 03:24:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[ID] [uniqueidentifier] NOT NULL,
	[OrderCost] [decimal](18, 6) NOT NULL
) ON [PRIMARY]

GO
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'4dcadd26-7cfa-481a-948f-cfb93ebd4bf9', CAST(53.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'0c19444e-c1e5-4d80-bee9-51295fbc0b70', CAST(45.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'f689b53b-c995-4eb9-91fa-533be6e3123e', CAST(49.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'29d44447-7e10-413b-8afb-05555f8fb343', CAST(41.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'2ff7dd2c-da84-4b53-8b47-d1fd3a954ca8', CAST(60.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'638fc9f3-e074-4670-9e3f-8a98ad862f31', CAST(56.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'daf7e304-7c88-46a0-8d62-574941d1816a', CAST(43.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'0c4d1102-ae9a-4518-aeaf-c06ca966a379', CAST(48.000000 AS Decimal(18, 6)))
INSERT [dbo].[Order] ([ID], [OrderCost]) VALUES (N'ba6f4c33-dee7-409d-90cc-788bedf5d2a4', CAST(45.000000 AS Decimal(18, 6)))
