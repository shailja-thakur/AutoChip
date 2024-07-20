module top_module(
    input wire clk,
    input wire rst,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    always @(posedge clk) begin
        if (rst) begin
            state <= 2'b00;  // idle state
            counter <= 8'd0;
            data <= 8'd0;
        end else begin
            case(state)
                2'b00: begin  // idle state
                    counter <= 8'd0;
                    data <= 8'd0;
                    state <= 2'b01;  // wait state
                end
                2'b01: begin  // wait state
                    counter <= counter + 1;
                    data <= 8'd0;
                    if (counter == 8'd10) begin  // threshold
                        state <= 2'b10;  // process state
                    end
                end
                2'b10: begin  // process state
                    data <= in;
                    state <= 2'b11;  // done state
                end
                2'b11: begin  // done state
                    data <= in;
                    valid_out <= 1'b1;
                    state <= 2'b00;  // idle state
                end
            endcase
        end
    end

    assign out = data_out;

endmodule
