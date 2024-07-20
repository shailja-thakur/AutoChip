module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam [1:0] STATE_A = 2'b00, STATE_B = 2'b01;

// Declare the state register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (in == 1'b0) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (in == 1'b0) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        default: begin
            next_state = STATE_B;
        end
    endcase
end

// Output logic
assign out = (state == STATE_B) ? 1'b1 : 1'b0;

// State register update
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_B;
    end else begin
        state <= next_state;
    end
end

endmodule
