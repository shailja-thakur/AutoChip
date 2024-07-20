module top_module (
    input clk,
    input a,
    output reg [2:0] q
);

    // Internal state to keep track of q
    reg [2:0] state;

    always @(posedge clk) begin
        if (a == 1) begin
            state <= 4;
        end else begin
            case (state)
                4: state <= 5;
                5: state <= 6;
                6: state <= 0;
                0: state <= 1;
                1: state <= 2;
                2: state <= 3;
                3: state <= 4;
                default: state <= 4;
            endcase
        end
    end

    always @(posedge clk) begin
        q <= state;
    end

endmodule
