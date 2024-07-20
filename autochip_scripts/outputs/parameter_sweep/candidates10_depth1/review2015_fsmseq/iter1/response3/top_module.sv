module top_module (
    input clk,
    input reset,
    input data,
    output reg start_shifting
);
    // Define states
    parameter IDLE = 2'b00;
    parameter S0 = 2'b01;
    parameter S1 = 2'b10;
    parameter S2 = 2'b11;
    
    reg [1:0] state;
    reg match;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            match <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (data) begin
                        state <= S0;
                    end
                end
                S0: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= IDLE;
                    end
                end
                S1: begin
                    if (data) begin
                        state <= S1;
                    end else begin
                        state <= S2;
                    end
                end
                S2: begin
                    if (data) begin
                        state <= S0;
                        match <= 1;
                    end else begin
                        state <= S2;
                    end
                end
            endcase
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            start_shifting <= 0;
        end else if (state == S2) begin
            start_shifting <= 1'b1;
        end
    end
    
endmodule
