module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
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
                state <= WAIT;
                counter <= 8'b0;
                data_out <= 1'b0;
            end
            WAIT: begin
                counter <= counter + 1'b1;
                data_out <= 1'b0;
                if (counter == 8'd255) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 1'b1; // set the data output
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1'b1; // set the valid output
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
