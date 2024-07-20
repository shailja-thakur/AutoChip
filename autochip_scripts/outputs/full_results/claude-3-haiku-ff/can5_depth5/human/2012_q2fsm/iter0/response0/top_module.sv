module top_module (
    input clk,
    input reset,
    input w,
    output z
);

// Define the states
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

// State register
reg [2:0] state;

// State table
always @(posedge clk, posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end else begin
        case (state)
            STATE_A: begin
                if (w) state <= STATE_B;
                else state <= STATE_A;
            end
            STATE_B: begin
                if (w) state <= STATE_C;
                else state <= STATE_D;
            end
            STATE_C: begin
                if (w) state <= STATE_E;
                else state <= STATE_D;
            end
            STATE_D: begin
                if (w) state <= STATE_F;
                else state <= STATE_A;
            end
            STATE_E: begin
                if (w) state <= STATE_E;
                else state <= STATE_D;
            end
            STATE_F: begin
                if (w) state <= STATE_C;
                else state <= STATE_D;
            end
            default: state <= STATE_A;
        endcase
    end
end

// Output logic
assign z = (state == STATE_E) || (state == STATE_F);

endmodule
