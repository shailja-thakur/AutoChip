module top_module (
    input clock,
    input a, 
    output reg p,
    output reg q
);

reg [1:0] state;

always @(posedge clock) begin
    case (state)
        2'd0: begin
            p <= 0;
            q <= 0;
            if (a) begin
                state <= 2'd1;
            end else begin
                state <= 2'd0;
            end
        end
        2'd1: begin
            p <= 0;
            q <= 0;
            state <= 2'd2;
        end
        2'd2: begin
            p <= 0;
            q <= 1;
            state <= 2'd3;
        end
        2'd3: begin
            p <= 1;
            q <= 0;
            if (a) begin
                state <= 2'd0;
            end else begin
                state <= 2'd3;
            end
        end
    endcase
end

endmodule
