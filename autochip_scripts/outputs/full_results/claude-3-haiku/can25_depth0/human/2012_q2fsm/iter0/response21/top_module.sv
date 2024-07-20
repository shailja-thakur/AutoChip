module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the state codes
localparam STATE_A = 3'b000;
localparam STATE_B = 3'b001;
localparam STATE_C = 3'b010;
localparam STATE_D = 3'b011;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

// Register to hold the current state
reg [2:0] current_state;

// State table
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= STATE_A;
    end else begin
        case (current_state)
            STATE_A: begin
                if (w) current_state <= STATE_B;
                else current_state <= STATE_A;
            end
            STATE_B: begin
                if (w) current_state <= STATE_C;
                else current_state <= STATE_D;
            end
            STATE_C: begin
                if (w) current_state <= STATE_E;
                else current_state <= STATE_D;
            end
            STATE_D: begin
                if (w) current_state <= STATE_F;
                else current_state <= STATE_A;
            end
            STATE_E: begin
                if (w) current_state <= STATE_E;
                else current_state <= STATE_D;
            end
            STATE_F: begin
                if (w) current_state <= STATE_C;
                else current_state <= STATE_D;
            end
            default: current_state <= STATE_A;
        endcase
    end
end

// Output logic
assign z = (current_state == STATE_E) || (current_state == STATE_F);

endmodule
