module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
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
        counter <= 0;
        data_out <= 0;
        valid <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 0;
                if (counter == 8'd100) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= 8'd42; // set the data_out to some value
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
