module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

localparam STATE_A = 3'b000;
localparam STATE_B = 3'b001;
localparam STATE_C = 3'b010;
localparam STATE_D = 3'b011;
localparam STATE_E = 3'b100;
localparam STATE_F = 3'b101;

reg [2:0] current_state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= STATE_A;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (w) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_B;
            end
            z = 0;
        end
        STATE_B: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
            z = 0;
        end
        STATE_C: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_E;
            end
            z = 0;
        end
        STATE_D: begin
            if (w) begin
                next_state = STATE_A;
            end
            else begin
                next_state = STATE_F;
            end
            z = 0;
        end
        STATE_E: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_E;
            end
            z = 1;
        end
        STATE_F: begin
            if (w) begin
                next_state = STATE_D;
            end
            else begin
                next_state = STATE_C;
            end
            z = 1;
        end
        default: begin
            next_state = STATE_A;
            z = 0;
        end
    endcase
end

endmodule
