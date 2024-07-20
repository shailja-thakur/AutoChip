module top_module(
    input wire clock,
    input wire reset,
    output wire data_out,
    output wire valid_out);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_out;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case(state)
                2'b00: begin // idle state
                    counter <= 8'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    if (in) begin
                        state <= 2'b01; // wait state
                    end
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    if (counter == 8'd10) begin
                        state <= 2'b10; // process state
                    end
                end
                2'b10: begin // process state
                    data_out <= in;
                    valid_out <= 1'b0;
                    state <= 2'b11; // done state
                end
                2'b11: begin // done state
                    valid_out <= 1'b1;
                    state <= 2'b00; // idle state
                end
            endcase
        end
    end

endmodule
