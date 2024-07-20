module top_module(
    input wire clk,
    input wire reset,
    output wire data_out,
    output wire valid_out
);
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_out_reg;

    always @(posedge clk, posedge reset) begin
        if (reset)
            state <= 2'b00; // idle state
        else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'b00000000;
                    data_out_reg <= 8'b00000000;
                    state <= 2'b01; // wait state
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data_out_reg <= 8'b00000000;
                    if (counter == 8'b01111111) // threshold value, change accordingly
                        state <= 2'b10; // process state
                end
                2'b10: begin // process state
                    data_out_reg <= in;
                    state <= 2'b11; // done state
                end
                2'b11: begin // done state
                    data_out_reg <= in;
                    valid_out <= 1'b1;
                    state <= 2'b00; // idle state
                end
            endcase
        end
    end

    assign data_out = data_out_reg;
endmodule
