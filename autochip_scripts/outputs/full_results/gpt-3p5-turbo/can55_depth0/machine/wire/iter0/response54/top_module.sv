module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [3:0] counter;
    reg [7:0] data;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00; // idle state
            counter <= 4'b0000;
            data <= 8'b00000000;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 4'b0000;
                    data <= 8'b00000000;
                    if (in)
                        state <= 2'b01; // wait state
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data <= 8'b00000000;
                    if (counter == 4'b1010) // threshold
                        state <= 2'b10; // process state
                end
                2'b10: begin // process state
                    data <= in;
                    state <= 2'b11; // done state
                end
                2'b11: begin // done state
                    data <= in;
                    valid_out <= 1'b1;
                    state <= 2'b00; // idle state
                end
                default: state <= 2'b00; // idle state
            endcase
        end
    end

    assign out = data_out;

endmodule
