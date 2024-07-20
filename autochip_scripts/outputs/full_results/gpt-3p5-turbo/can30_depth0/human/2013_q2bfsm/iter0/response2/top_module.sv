module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
    
    reg f;
    reg g;
    reg [1:0] state;
    reg [2:0] x_history;
    wire x_detected;
    reg [1:0] y_history;
    wire y_detected;
    
    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            state <= 2'b0;
            f <= 1'b0;
            g <= 1'b0;
            x_history <= 3'b0;
            y_history <= 2'b0;
        end else begin
            case (state)
                // State A
                2'b00: begin
                    f <= 1'b0;
                    g <= 1'b0;
                    if (~resetn) begin
                        state <= 2'b01;
                    end
                end
                // State B
                2'b01: begin
                    f <= 1'b1;
                    state <= 2'b10;
                end
                // State C
                2'b10: begin
                    if (x_detected) begin
                        g <= 1'b1;
                        state <= 2'b11;
                    end
                end
                // State D
                2'b11: begin
                    if (y_detected) begin
                        g <= 1'b1;
                    end else begin
                        g <= 1'b0;
                    end
                end
            endcase
        end
    end
    
    assign x_detected = (x_history == 3'b101);
    assign y_detected = (y_history[1] & y_history[0]);

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            x_history <= 3'b0;
        end else begin
            x_history <= {x_history[1:0], x};
        end
    end

    always @(posedge clk or negedge resetn) begin
        if (~resetn) begin
            y_history <= 2'b0;
        end else begin
            y_history <= {y_history[0], y};
        end
    end
    
endmodule
