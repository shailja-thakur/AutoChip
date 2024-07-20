module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the states
parameter STATE_A = 3'b000;
parameter STATE_B = 3'b001;
parameter STATE_C = 3'b010;
parameter STATE_D = 3'b011;
parameter STATE_E = 3'b100;
parameter STATE_F = 3'b101;

// Define the current state and next state variables
reg [2:0] current_state;
reg [2:0] next_state;

// Define the output signal z
wire z;

// Assign next state based on current state and input w
always @(*) begin
    case (current_state)
        STATE_A: begin
            next_state = (w == 1'b0) ? STATE_B : STATE_A;
        end
        STATE_B: begin
            next_state = (w == 1'b1) ? STATE_D : STATE_C;
        end
        STATE_C: begin
            next_state = (w == 1'b0) ? STATE_E : STATE_D;
        end
        STATE_D: begin
            next_state = (w == 1'b1) ? STATE_A : STATE_F;
        end
        STATE_E: begin
            next_state = (w == 1'b0) ? STATE_D : STATE_E;
        end
        STATE_F: begin
            next_state = (w == 1'b1) ? STATE_D : STATE_C;
        end
        default: next_state = STATE_A;
    endcase
end

// Assign current state based on clk and reset
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= STATE_A;
    end else begin
        current_state <= next_state;
    end
end

// Assign output z
assign z = (current_state == STATE_E || current_state == STATE_F) ? 1'b1 : 1'b0;

endmodule
