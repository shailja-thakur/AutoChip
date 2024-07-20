module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    reg [1:0] state;
    reg [7:0] counter;

    parameter IDLE = 2'b00;
    parameter WAIT = 2'b01;
    parameter PROCESS = 2'b10;
    parameter DONE = 2'b11;

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 8'd1;
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                    if (counter == 8'd100) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 8'hAA; // Set the processed data here
                    valid_out <= 1'b1;
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b0;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
