module top_module(
    input wire clk,
    input wire reset,
    output reg out,
    output reg valid
);

    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data_output;
    
    parameter IDLE = 2'd0;
    parameter WAIT = 2'd1;
    parameter PROCESS = 2'd2;
    parameter DONE = 2'd3;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            data_output <= 8'b0;
            counter <= 8'b0;
            valid <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    if (reset) begin
                        state <= IDLE;
                        data_output <= 8'b0;
                        counter <= 8'b0;
                        valid <= 1'b0;
                    end else begin
                        state <= WAIT;
                        counter <= 8'b0;
                        data_output <= 8'b0;
                    end
                end
                
                WAIT: begin
                    if (counter >= 8'hFF) begin
                        state <= PROCESS;
                        counter <= 8'b0;
                        data_output <= in;
                    end else begin
                        state <= WAIT;
                        counter <= counter + 1;
                        data_output <= 8'b0;
                    end
                end
                
                PROCESS: begin
                    state <= DONE;
                    data_output <= in;
                    valid <= 1'b1;
                end
                
                DONE: begin
                    state <= IDLE;
                    data_output <= 8'b0;
                    valid <= 1'b0;
                end
            endcase
        end
    end
    
    assign out = data_output;

endmodule
