module top_module(
    input wire clk,
    input wire reset,
    output wire data_output,
    output wire valid_output);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'b00000000;
            data <= 8'b00000000;
        end else begin
            case(state)
                2'b00: begin // idle state
                    counter <= 8'b00000000;
                    data <= 8'b00000000;
                    state <= 2'b01;
                end

                2'b01: begin // wait state
                    counter <= counter + 1;
                    data <= 8'b00000000;
                    if (counter == 8'hFF) begin
                        state <= 2'b10;
                    end
                end

                2'b10: begin // process state
                    data <= in;
                    state <= 2'b11;
                end

                2'b11: begin // done state
                    data <= in;
                    valid_output <= 1'b1;
                    state <= 2'b00;
                end
            endcase
        end
    end

    assign out = data_output;

endmodule
