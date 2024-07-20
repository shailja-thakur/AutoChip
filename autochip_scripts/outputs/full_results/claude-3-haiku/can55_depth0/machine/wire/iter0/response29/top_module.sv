module top_module(
    input clk,
    input reset,
    output data_out,
    output valid_out
);

reg state;
reg [7:0] counter;

localparam IDLE = 0;
localparam WAIT = 1;
localparam PROCESS = 2;
localparam DONE = 3;

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
                counter <= 0;
                data_out <= 0;
                valid_out <= 0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 8'h64) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 8'h55; // set the data output to some value
                state <= DONE;
            end
            DONE: begin
                valid_out <= 1;
                state <= IDLE;
            end
            default: begin
                state <= IDLE;
            end
        endcase
    end
end

endmodule
