module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// Declare the state register
reg [1:0] current_state, next_state;

// State transition logic
always @(*)
begin
    case (current_state)
        STATE_A: begin
            if (in == 1'b0)
                next_state = STATE_A;
            else
                next_state = STATE_B;
            out = 1'b0;
        end
        STATE_B: begin
            if (in == 1'b0)
                next_state = STATE_C;
            else
                next_state = STATE_B;
            out = 1'b0;
        end
        STATE_C: begin
            if (in == 1'b0)
                next_state = STATE_A;
            else
                next_state = STATE_D;
            out = 1'b0;
        end
        STATE_D: begin
            if (in == 1'b0)
                next_state = STATE_C;
            else
                next_state = STATE_B;
            out = 1'b1;
        end
        default: begin
            next_state = STATE_A;
            out = 1'b0;
        end
    endcase
end

// State update logic
always @(posedge clk or posedge reset)
begin
    if (reset)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

endmodule
