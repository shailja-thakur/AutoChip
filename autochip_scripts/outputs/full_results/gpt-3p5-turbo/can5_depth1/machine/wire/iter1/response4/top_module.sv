module top_module(
    input clk,
    input reset,
    input in,
    output reg out
);

    reg [1:0] state;
    reg [7:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'b0;
            out <= 1'b0;
        end
        else begin
            case (state)
                2'b00: begin
                    counter <= 8'b0;
                    out <= 1'b0;
                    state <= 2'b01;
                end

                2'b01: begin
                    counter <= counter + 1;
                    out <= 1'b0;

                    if (counter >= 10) begin
                        counter <= 8'b0;
                        state <= 2'b10;
                    end
                end

                2'b10: begin
                    out <= in;
                    state <= 2'b11;
                end

                2'b11: begin
                    out <= 1'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end

endmodule
