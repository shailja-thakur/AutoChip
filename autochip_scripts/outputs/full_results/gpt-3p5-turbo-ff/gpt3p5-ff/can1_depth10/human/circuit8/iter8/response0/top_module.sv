module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

    reg [3:0] state;

    always @(posedge clock) begin
        case (state)
            4'b0000: begin
                p <= 0;
                q <= 0;
                if (a == 0)
                    state <= 4'b0001;
                else
                    state <= 4'b1111;
            end

            4'b0001: begin
                p <= 0;
                q <= 0;
                state <= 4'b0010;
            end

            4'b0010: begin
                p <= 1;
                q <= 0;
                state <= 4'b0011;
            end

            4'b0011: begin
                p <= 0;
                q <= 0;
                state <= 4'b0100;
            end

            4'b0100: begin
                p <= 1;
                q <= 0;
                if (a == 0)
                    state <= 4'b0101;
                else
                    state <= 4'b0110;
            end

            4'b0101: begin
                p <= 0;
                q <= 1;
                state <= 4'b1000;
            end

            4'b0110: begin
                p <= 0;
                q <= 1;
                state <= 4'b0101;
            end

            4'b1000: begin
                p <= 0;
                q <= 1;
                state <= 4'b0110;
            end
            
            4'b0111: begin
                p <= 0;
                q <= 0;
                state <= 4'b1000;
            end

            default: begin
                p <= 0;
                q <= 0;
                state <= 4'b0000;
            end
        endcase
    end

endmodule
