module top_module (
    input clk,
    input reset,
    output reg [31:0] data_out,
    output reg valid
);

// Internal signals
reg [1:0] state;
reg [31:0] counter;

localparam IDLE  = 2'b00;
localparam WAIT  = 2'b01;
localparam PROCESS = 2'b10;
localparam DONE  = 2'b11;

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
                if (counter == 32'hFFFF_FFFF) begin // Threshold reached
                    state <= PROCESS;
                    counter <= 0;
                end
            end
            PROCESS: begin
                // Set the data_out based on the processing logic
                data_out <= 32'hDEAD_BEEF;
                state <= DONE;
            end
            DONE: begin
                valid <= 1;
                state <= IDLE;
            end
            default: state <= IDLE;
        endcase
    end
end

endmodule
