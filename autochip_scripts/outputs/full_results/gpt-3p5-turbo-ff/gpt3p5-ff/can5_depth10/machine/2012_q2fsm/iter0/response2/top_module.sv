module top_module (
    input clk,
    input reset,
    input w,
    output z
);

reg [2:0] state, next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= 3'b000;
    else
        state <= next_state;
end

always @(state or w) begin
    case (state)
        3'b000: begin
            if (w)
                next_state = 3'b001;
            else
                next_state = 3'b000;
        end
        3'b001: begin
            if (w)
                next_state = 3'b010;
            else
                next_state = 3'b011;
        end
        3'b010: begin
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b011;
        end
        3'b011: begin
            if (w)
                next_state = 3'b000;
            else
                next_state = 3'b011;
        end
        3'b100: begin
            if (w)
                next_state = 3'b100;
            else
                next_state = 3'b100;
        end
        3'b101: begin
            if (w)
                next_state = 3'b110;
            else
                next_state = 3'b100;
        end
        default: begin
            if (w)
                next_state = 3'b110;
            else
                next_state = 3'b010;
        end
    endcase
end

assign z = (state == 3'b100) || (state == 3'b101);

endmodule
