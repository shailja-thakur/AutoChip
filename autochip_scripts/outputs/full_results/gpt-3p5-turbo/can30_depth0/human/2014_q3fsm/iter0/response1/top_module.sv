module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;

// Declare states
parameter A = 2'b00;
parameter B = 2'b01;

// Reset state
always @(posedge clk, posedge reset)
begin
    if (reset)
        state <= A;
    else
        state <= state;
end

// Next state logic
always @(posedge clk)
begin
    case(state)
        A: if (s)
               state <= B;
           else
               state <= A;
        B: state <= A;
    endcase
end

// Output logic
always @(posedge clk)
begin
    // Initialize output z
    z <= 0;
    
    // Check w for the next three clock cycles
    if (state == B)
    begin
        case(w)
            2'b00: z <= 0;
            2'b01: z <= 0;
            2'b10: z <= 0;
            2'b11: z <= 1;
        endcase
    end
end

endmodule
