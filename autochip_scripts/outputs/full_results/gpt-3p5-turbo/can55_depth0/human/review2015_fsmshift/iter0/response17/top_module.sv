module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state; 
    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    always @(state or reset) begin
        case(state)
            3'b000: begin
                if(reset) begin
                    next_state <= 3'b000;
                end else if(/* insert condition for detecting proper bit pattern */) begin
                    next_state <= 3'b001;
                end else begin
                    next_state <= 3'b000;
                end
            end

            3'b001: begin
                if(reset) begin
                    next_state <= 3'b000;
                end else begin
                    next_state <= 3'b010;
                end
            end

            3'b010: begin
                if(reset) begin
                    next_state <= 3'b000;
                end else begin
                    next_state <= 3'b011;
                end
            end

            3'b011: begin
                if(reset) begin
                    next_state <= 3'b000;
                end else begin
                    next_state <= 3'b000;
                end
            end
        endcase
    end

    always @(state) begin
        case(state)
            3'b000: begin
                shift_ena = 1'b0;
            end

            3'b001: begin
                shift_ena = 1'b1;
            end

            3'b010: begin
                shift_ena = 1'b1;
            end

            3'b011: begin
                shift_ena = 1'b1;
            end
        endcase
    end

endmodule
