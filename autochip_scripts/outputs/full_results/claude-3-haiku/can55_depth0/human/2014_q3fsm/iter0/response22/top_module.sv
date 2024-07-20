module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

parameter STATE_A = 2'b00; // Reset state
parameter STATE_B = 2'b01; // Check w for 3 cycles
parameter STATE_C = 2'b10; // Determine output z

reg [1:0] current_state, next_state;
reg [1:0] w_count;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_A;
        w_count <= 2'b00;
        z <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        STATE_A: begin
            if (s) begin
                next_state = STATE_B;
            end
            else begin
                next_state = STATE_A;
            end
        end
        STATE_B: begin
            if (w_count == 2'b10) begin
                next_state = STATE_C;
            end
            else begin
                next_state = STATE_B;
            end
        end
        STATE_C: begin
            z = 1'b1;
            next_state = STATE_A;
        end
        default: begin
            next_state = STATE_A;
        end
    endcase
end

always @(posedge clk) begin
    case (current_state)
        STATE_B: begin
            if (w) begin
                w_count <= w_count + 1'b1;
            end
            else begin
                w_count <= w_count;
            end
        end
        default: begin
            w_count <= 2'b00;
        end
    endcase
end

endmodule
