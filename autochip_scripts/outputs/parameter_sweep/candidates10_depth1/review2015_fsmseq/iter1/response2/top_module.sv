module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    // Define states
    localparam IDLE = 2'b00;
    localparam S0 = 2'b01;
    localparam S1 = 2'b10;
    localparam S2 = 2'b11;

    // Define signals
    reg [1:0] state;
    reg match;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            match <= 0;
            start_shifting <= 0;
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
                        start_shifting <= 1;
                    end else begin
                        state <= S2;
                        start_shifting <= 0;
                    end
                end
            endcase
        end
    end

endmodule
