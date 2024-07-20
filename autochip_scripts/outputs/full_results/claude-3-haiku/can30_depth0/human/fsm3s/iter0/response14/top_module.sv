module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// State assignment
localparam STATE_A = 2'b00;
localparam STATE_B = 2'b01;
localparam STATE_C = 2'b10;
localparam STATE_D = 2'b11;

// State register
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_A: begin
            next_state = (in) ? STATE_B : STATE_A;
            out = 1'b0;
        end
        STATE_B: begin
            next_state = (in) ? STATE_B : STATE_C;
            out = 1'b0;
        end
        STATE_C: begin
            next_state = (in) ? STATE_D : STATE_A;
            out = 1'b0;
        end
        STATE_D: begin
            next_state = (in) ? STATE_B : STATE_C;
            out = 1'b1;
        end
        default: begin
            next_state = STATE_A;
            out = 1'b0;
        end
    endcase
end

// State register update
always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= STATE_A;
    end
    else begin
        state <= next_state;
    end
end

endmodule
