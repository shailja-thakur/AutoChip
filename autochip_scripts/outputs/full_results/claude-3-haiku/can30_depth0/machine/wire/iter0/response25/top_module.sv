module top_module(
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
);

reg [1:0] state;
reg [7:0] counter;

localparam IDLE = 2'd0;
localparam WAIT = 2'd1;
localparam PROCESS = 2'd2;
localparam DONE = 2'd3;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 8'd0;
        data_out <= 1'd0;
        valid_out <= 1'd0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 8'd0;
                data_out <= 1'd0;
                valid_out <= 1'd0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 8'd1;
                data_out <= 1'd0;
                valid_out <= 1'd0;
                if (counter == 8'd255) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                // Set the data_out to the data being processed
                data_out <= 1'd1;
                valid_out <= 1'd1;
                state <= DONE;
            end
            DONE: begin
                data_out <= 1'd0;
                valid_out <= 1'd0;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
