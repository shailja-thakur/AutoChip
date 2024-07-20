module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
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
        counter <= 8'd0;
        data_out <= 8'd0;
        valid <= 1'b0;
    end
    else begin
        case (state)
            IDLE: begin
                state <= WAIT;
            end
            WAIT: begin
                counter <= counter + 8'd1;
                data_out <= 8'd0;
                if (counter == 8'd10) begin
                    state <= PROCESS;
                end
            end
            PROCESS: begin
                data_out <= 8'd42; // Placeholder for actual data processing
                state <= DONE;
            end
            DONE: begin
                valid <= 1'b1;
                state <= IDLE;
            end
        endcase
    end
end

endmodule
