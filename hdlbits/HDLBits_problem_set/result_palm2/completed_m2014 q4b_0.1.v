module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q);

    reg [1:0] state;
    reg q;

    always @(posedge clk or posedge ar) begin
        if (ar) begin
            state <= 1;
        end else begin
            case (state)
                0:
                    q <= d;
                    state <= 1;
                1:
                    q <= 0;
                    state <= 0;
            endcase
        end
    end

endmodule