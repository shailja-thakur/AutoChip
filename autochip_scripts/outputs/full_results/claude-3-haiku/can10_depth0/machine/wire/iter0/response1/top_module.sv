module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

reg [1:0] state;
reg [3:0] counter;

parameter IDLE = 2'b00, WAIT = 2'b01, PROCESS = 2'b10, DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 4'b0;
        data_out <= 8'b0;
        valid <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 8'b0;
                if (counter == 4'd10) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= 8'hAA; // Set the data output to be processed
                state <= DONE;
            end
            DONE: begin
                valid <= 1'b1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
