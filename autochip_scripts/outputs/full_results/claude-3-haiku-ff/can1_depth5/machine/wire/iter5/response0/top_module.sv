module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

reg [1:0] state;
reg [7:0] counter;

localparam IDLE = 2'b00;
localparam WAIT = 2'b01;
localparam PROCESS = 2'b10;
localparam DONE = 2'b11;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
        valid_out <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
                counter <= 0;
            end
            WAIT: begin
                counter <= counter + 1;
                if (counter == 8'd255) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                // Process the input data and set data_out
                data_out <= 8'h55; // Set the output data
                valid_out <= 1; // Set the valid output
                state <= DONE;
            end
            DONE: begin
                valid_out <= 0; // Reset the valid output
                state <= IDLE;
            end
        endcase
    end
end

endmodule
