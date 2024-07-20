module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

reg [1:0] state;
parameter A = 2'b00, B = 2'b01, C = 2'b10;
reg [1:0] count;

always @(posedge clk) begin
    if (reset) begin
        state <= A;
        count <= 0;
        z <= 0;
    end
    else begin
        case (state)
            A: begin
                if (s == 1'b1)
                    state <= B;
                else
                    state <= A;
            end
            B: begin
                if (w == 1'b1)
                    count <= count + 1;
                else
                    count <= count;
                
                if (count == 2'b10)
                    z <= 1'b1;
                else
                    z <= 1'b0;
                
                state <= C;
            end
            C: begin
                if (w == 1'b1)
                    count <= count + 1;
                else
                    count <= count;
                
                if (count == 2'b10)
                    z <= 1'b1;
                else
                    z <= 1'b0;
                
                state <= A;
            end
            default:
                state <= A;
        endcase
    end
end

endmodule
