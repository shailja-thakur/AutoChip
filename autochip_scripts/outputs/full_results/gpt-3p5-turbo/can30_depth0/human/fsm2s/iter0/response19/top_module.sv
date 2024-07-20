module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output out
);

    reg out;
    reg [1:0] state;
    reg [1:0] nextState;

    parameter OFF = 2'b00;
    parameter ON = 2'b01;

    always @(posedge clk) begin
        if (reset) begin
            state <= OFF;
        end else begin
            state <= nextState;
        end
    end

    always @(state or j or k) begin
        case(state)
            OFF: begin
                if (j) begin
                    nextState = ON;
                end else begin
                    nextState = OFF;
                end
            end

            ON: begin
                if (k) begin
                    nextState = OFF;
                end else begin
                    nextState = ON;
                end
            end
        endcase
    end

    always @(state) begin
        case(state)
            OFF: begin
                out = 1'b0;
            end

            ON: begin
                out = 1'b1;
            end
        endcase
    end
endmodule
