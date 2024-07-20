module top_module(
    input clk,
    input reset,
    output reg data_out,
    output reg valid
);

reg [1:0] state;
reg [7:0] counter;

parameter IDLE = 2'd0;
parameter WAIT = 2'd1;
parameter PROCESS = 2'd2;
parameter DONE = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 8'd0;
        data_out <= 1'b0;
        valid <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 1'b0;
                if (counter == 8'd100) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                // Perform processing on the data
                data_out <= 1'b1;
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
