module top_module (
    input clk,
    input in,
    input reset,
    output done
);

reg [2:0] state;
reg done;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= 3'b000;
        done <= 1'b0;
    end else begin
        case(state)
            3'b000:
                if (in == 1'b0)
                    state <= 3'b001;
                else
                    state <= 3'b000;
            3'b001:
                state <= 3'b010;
            3'b010:
                state <= 3'b011;
            3'b011:
                state <= 3'b100;
            3'b100:
                if (in == 1'b1)
                    state <= 3'b101;
                else
                    state <= 3'b100;
            3'b101:
                state <= 3'b000;
                done <= 1'b1;
        endcase
    end
end

endmodule
