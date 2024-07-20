module top_module(
    input wire clk,
    input wire reset,
    output reg out
);
    
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;
    reg valid;
    
    initial begin
        state = 2'b00;
        counter = 8'd0;
        data = 8'd0;
        valid = 0;
    end
    
    always @(posedge clk) begin
        if (reset) begin
            state <= 2'b00;
            counter <= 8'd0;
            data <= 8'd0;
            valid <= 0;
        end else begin
            case (state)
                2'b00: begin // idle state
                    counter <= 8'd0;
                    data <= 8'd0;
                    state <= 2'b01;
                end
                
                2'b01: begin // wait state
                    counter <= counter + 1;
                    data <= 8'd0;
                    if (counter >= 8'd<counter_threshold>) begin
                        state <= 2'b10;
                    end
                end
                
                2'b10: begin // process state
                    data <= <process_data>;
                    state <= 2'b11;
                end
                
                2'b11: begin // done state
                    valid <= 1;
                    state <= 2'b00;
                end
            endcase
        end
    end
    
    assign out = data;
    
endmodule
