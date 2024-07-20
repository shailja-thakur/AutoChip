module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
    end else begin
        state <= next_state;
    end
end

always @(state or w) begin
    case (state)
        3'b000: begin
            if (w == 1'b0) begin
                next_state = 3'b000;
            end else begin
                next_state = 3'b001;
            end
        end
        3'b001: begin
            if (w == 1'b0) begin
                next_state = 3'b100;
            end else begin
                next_state = 3'b010;
            end
        end
        3'b010: begin
            if (w == 1'b0) begin
                next_state = 3'b100;
            end else begin
                next_state = 3'b011;
            end
        end
        3'b011: begin
            if (w == 1'b0) begin
                next_state = 3'b000;
            end else begin
                next_state = 3'b101;
            end
        end
        3'b100: begin
            if (w == 1'b0) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b100;
            end
        end
        3'b101: begin
            if (w == 1'b0) begin
                next_state = 3'b011;
            end else begin
                next_state = 3'b110;
            end
        end
        default: begin
            next_state = 3'b010;
        end
    endcase
end

assign z = (state == 3'b100) || (state == 3'b110);

endmodule
