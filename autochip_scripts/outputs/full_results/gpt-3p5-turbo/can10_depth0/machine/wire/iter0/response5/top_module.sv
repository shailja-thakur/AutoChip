module top_module(
    input wire clk,
    input wire reset,
    output wire data_out,
    output wire valid_out
);

    reg [1:0] state;
    reg [3:0] counter;
    reg [7:0] data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 4'b0000;
            data <= 8'b00000000;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 4'b0000;
                    data <= 8'b00000000;
                    state <= 2'b01;
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data <= 8'b00000000;
                    if (counter == 4'b1010) // check if counter reaches threshold
                        state <= 2'b10;
                end
                2'b10: begin // process state
                    data <= in;
                    state <= 2'b11;
                end
                2'b11: begin // done state
                    data <= in;
                    valid_out <= 1;
                    state <= 2'b00;
                end
            endcase
        end
    end

    assign out = data_out;

endmodule
