module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

reg [1:0] state;
reg [1:0] next_state;

// State A is 2'b00, State B is 2'b01
parameter STATE_A = 2'b00;
parameter STATE_B = 2'b01;

// Initializing the state to A
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end else begin
        state <= next_state;
    end
end

// Defining the next state based on the current state and inputs j and k
always @* begin
    case(state)
        STATE_A: begin
            if (j) begin
                next_state = STATE_B;
            end else begin
                next_state = STATE_A;
            end
        end
        
        STATE_B: begin
            if (k) begin
                next_state = STATE_A;
            end else begin
                next_state = STATE_B;
            end
        end
    endcase
end

// Output is high when in state B, low when in state A
assign out = (state == STATE_B) ? 1'b1 : 1'b0;

endmodule
