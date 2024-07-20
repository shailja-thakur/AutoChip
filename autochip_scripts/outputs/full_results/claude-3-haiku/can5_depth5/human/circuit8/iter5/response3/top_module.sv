module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg state;

always @ (posedge clock) begin
    case (state)
        1'b0: begin
            p <= 1'b0;
            q <= 1'b0;
            if (a == 1'b1) begin
                state <= 1'b1;
            end
        end
        1'b1: begin
            if (a == 1'b0) begin
                p <= 1'b0;
                q <= 1'b1;
            end
            else begin
                p <= 1'b1;
                q <= 1'b0;
                state <= 1'b0;
            end
        end
        default: begin
            p <= 1'b0;
            q <= 1'b0;
            state <= 1'b0;
        end
    endcase
end

endmodule
