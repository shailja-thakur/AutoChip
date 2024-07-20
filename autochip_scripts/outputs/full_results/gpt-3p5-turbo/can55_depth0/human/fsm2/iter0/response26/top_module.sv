module top_module (
    input clk,
    input j,
    input k,
    input areset,
    output out
);

reg [1:0] state; // State register
reg out_reg; // Output register

// State definitions
parameter OFF = 2'b00;
parameter ON = 2'b01;

// Initial state
always @(posedge clk or posedge areset)
begin
    if (areset)
        state <= OFF;
    else
        case (state)
            OFF: state <= (j) ? ON : OFF;
            ON: state <= (k) ? OFF : ON;
            default: state <= OFF;
        endcase
end

// Output logic
always @(state, j, k)
begin
    case (state)
        OFF: out_reg = 1'b0;
        ON: out_reg = 1'b1;
        default: out_reg = 1'b0;
    endcase
end

// Output assignment
assign out = out_reg;

endmodule
