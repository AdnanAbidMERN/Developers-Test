﻿CREATE TABLE [dbo].[SHIPMENT_RATE](
	[shipment_rate_id] [int] NOT NULL,
	[shipment_rate_class] [varchar](10) NOT NULL,
	[shipment_rate_description] [varchar](25) NOT NULL
 CONSTRAINT [PK_SHIPMENT_RATE] PRIMARY KEY CLUSTERED 
(
	[shipment_rate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]