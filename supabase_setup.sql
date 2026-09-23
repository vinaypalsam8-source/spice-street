-- ==============================================================================
-- SPICE STREET - SUPABASE POSTGRESQL DATABASE SETUP
-- Execute this script in your Supabase SQL Editor:
-- https://supabase.com/dashboard/project/_/sql
-- ==============================================================================

-- 1. Create Spice Street Orders Table
CREATE TABLE IF NOT EXISTS public.orders (
  id BIGSERIAL PRIMARY KEY,
  order_id TEXT UNIQUE NOT NULL,
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  customer_name TEXT NOT NULL,
  phone TEXT NOT NULL,
  email TEXT,
  street_address TEXT NOT NULL,
  landmark TEXT,
  pincode TEXT,
  items JSONB NOT NULL,
  subtotal NUMERIC NOT NULL,
  discount_amount NUMERIC DEFAULT 0,
  delivery_fee NUMERIC DEFAULT 0,
  grand_total NUMERIC NOT NULL,
  payment_mode TEXT NOT NULL,
  payment_status TEXT DEFAULT 'Pending',
  order_status TEXT DEFAULT 'Order Received',
  utr TEXT DEFAULT 'N/A',
  shipment JSONB DEFAULT '{"riderName": "Not Assigned", "riderPhone": "N/A", "vehicleNo": "N/A", "status": "Pending"}'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;

-- 3. Public Policies for Live Store Operations
DROP POLICY IF EXISTS "Public can insert orders" ON public.orders;
CREATE POLICY "Public can insert orders" ON public.orders FOR INSERT WITH CHECK (true);

DROP POLICY IF EXISTS "Public can view orders" ON public.orders;
CREATE POLICY "Public can view orders" ON public.orders FOR SELECT USING (true);

DROP POLICY IF EXISTS "Public can update orders" ON public.orders;
CREATE POLICY "Public can update orders" ON public.orders FOR UPDATE USING (true);

DROP POLICY IF EXISTS "Public can delete orders" ON public.orders;
CREATE POLICY "Public can delete orders" ON public.orders FOR DELETE USING (true);

-- 4. Enable Supabase Realtime for instant Live Order Alerts & Kitchen Buzzer
ALTER PUBLICATION supabase_realtime ADD TABLE public.orders;

-- Verify
SELECT 'Spice Street Supabase Database configured successfully!' as result;
