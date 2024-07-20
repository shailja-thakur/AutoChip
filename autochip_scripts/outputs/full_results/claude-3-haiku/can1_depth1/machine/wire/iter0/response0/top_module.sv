module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            state <= 2'd0; // idle state
            counter <= 8'd0;
            data_out <= 1'b0;
        end
        else begin
            case (state)
                2'd0: begin // idle state
                    counter <= 8'd0;
                    data_out <= 1'b0;
                    state <= 2'd1; // transition to wait state
                end
                2'd1: begin // wait state
                    counter <= counter + 8'd1;
                    data_out <= 1'b0;
                    if (counter == 8'd100) begin // threshold reached
                        state <= 2'd2; // transition to process state
                    end
                    else begin
                        state <= 2'd1; // remain in wait state
                    end
                end
                2'd2: begin // process state
                    data_out <= 1'b1; // set data output
                    state <= 2'd3; // transition to done state
                end
                2'd3: begin // done state
                    valid_out <= 1'b1; // assert valid output
                    state <= 2'd0; // transition back to idle state
                end
                default: begin
                    state <= 2'd0; // default to idle state
                end
            endcase
        end
    end

endmodule
