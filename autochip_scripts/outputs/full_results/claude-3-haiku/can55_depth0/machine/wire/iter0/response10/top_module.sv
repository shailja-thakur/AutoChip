module top_module(
    input clock,
    input reset,
    output reg [31:0] data_out,
    output reg valid
);

reg [1:0] state;
reg [31:0] counter;

parameter IDLE = 2'd0;
parameter WAIT = 2'd1;
parameter PROCESS = 2'd2;
parameter DONE = 2'd3;

always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        counter <= 0;
        data_out <= 0;
        valid <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                counter <= 0;
                data_out <= 0;
                valid <= 0;
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 32'd1000) begin
                    state <= PROCESS;
                end
                else begin
                    state <= WAIT;
                end
            end
            PROCESS: begin
                // Perform some processing on the data
                data_out <= 32'hdeadbeef;
                state <= DONE;
            end
            DONE: begin
                valid <= 1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
