module top_module(
    input wire clk,
    input wire reset,
    output reg out,
    output reg valid
    );

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_output;

    // Initial state
    initial begin
        state = 2'b00;
        counter = 8'd0;
        data_output = 8'd0;
        out = 1'b0;
        valid = 1'b0;
    end

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            state <= 2'b00;
            counter <= 8'd0;
            data_output <= 8'd0;
            out <= 1'b0;
            valid <= 1'b0;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'd0;
                    data_output <= 8'd0;
                end
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data_output <= 8'd0;
                    if (counter >= 8'd10) begin // threshold
                        state <= 2'b10; // transition to process state
                    end
                end
                2'b10: begin // process state
                    data_output <= in;
                    state <= 2'b11; // transition to done state
                end
                2'b11: begin // done state
                    valid <= 1'b1;
                    state <= 2'b00; // transition back to idle state
                end
                default: state <= 2'b00; // default to idle state
            endcase
        end
    end
endmodule
