module top_module(
    input clk,
    input reset,
    output reg data_out,
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
        counter <= 8'b0;
        data_out <= 1'b0;
        valid_out <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 8'b0;
                data_out <= 1'b0;
                valid_out <= 1'b0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 1'b0;
                if (counter == 8'd10) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 1'b1; // Set the data_out signal to 1
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1'b1; // Assert the valid_out signal
                state <= IDLE;
            end
        endcase
    end
end

endmodule
